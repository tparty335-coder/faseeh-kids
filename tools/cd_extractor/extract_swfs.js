const fs = require("fs");
const path = require("path");
const zlib = require("zlib");

const exePath = "D:/Education  vol2/مناهج 2026/ص1         ت1/arabic_1Prim_t1_u2l2ب.exe";
const outDir = "D:/Projects/faseeh_kids/scratch/extracted_baa_swfs";
fs.mkdirSync(outDir, { recursive: true });

const buf = fs.readFileSync(exePath);
console.log("Total EXE size:", buf.length);

let offset = 0;
let swfIndex = 0;
const validSwfs = [];

while (offset < buf.length - 8) {
  const sig = buf.toString("ascii", offset, offset + 3);
  if (sig === "CWS" || sig === "FWS") {
    const version = buf.readUInt8(offset + 3);
    const uncompressedLength = buf.readUInt32LE(offset + 4);
    
    // Validate reasonable SWF version and size
    if (version >= 4 && version <= 30 && uncompressedLength > 100 && uncompressedLength < 200 * 1024 * 1024) {
      if (sig === "CWS") {
        // Test inflate from offset + 8
        try {
          // We can slice from offset + 8 up to some max or until decompression finishes
          // zlib.inflateRaw or inflate
          // Flash CWS uses standard zlib header (RFC 1950)
          let decompressed = null;
          let compressedEnd = -1;
          
          // Try inflating slices of increasing size or with stream
          for (let testLen = 1024; testLen <= Math.min(buf.length - offset, uncompressedLength * 2); testLen += 4096) {
            try {
              const testSlice = buf.subarray(offset + 8, offset + 8 + testLen);
              decompressed = zlib.inflateSync(testSlice);
              if (decompressed.length + 8 === uncompressedLength) {
                compressedEnd = offset + 8 + testLen;
                break;
              }
            } catch (e) {
              // keep expanding
            }
          }

          if (decompressed && decompressed.length + 8 === uncompressedLength) {
            const swfData = buf.subarray(offset, compressedEnd);
            const fileName = `swf_${String(swfIndex).padStart(3, "0")}_v${version}_len${uncompressedLength}.swf`;
            const outPath = path.join(outDir, fileName);
            fs.writeFileSync(outPath, swfData);
            console.log(`[Extracted SWF ${swfIndex}] ${fileName} (CompSize: ${swfData.length}, Uncomp: ${uncompressedLength})`);
            validSwfs.push({ index: swfIndex, fileName, offset, size: swfData.length });
            swfIndex++;
            offset = compressedEnd;
            continue;
          }
        } catch (err) {
          // not a clean CWS
        }
      } else if (sig === "FWS") {
        const swfData = buf.subarray(offset, offset + uncompressedLength);
        const fileName = `swf_${String(swfIndex).padStart(3, "0")}_raw_len${uncompressedLength}.swf`;
        fs.writeFileSync(path.join(outDir, fileName), swfData);
        console.log(`[Extracted Raw SWF ${swfIndex}] ${fileName}`);
        validSwfs.push({ index: swfIndex, fileName, offset, size: uncompressedLength });
        swfIndex++;
        offset += uncompressedLength;
        continue;
      }
    }
  }
  offset++;
}

console.log(`\nSuccessfully extracted ${validSwfs.length} SWF files to ${outDir}`);
