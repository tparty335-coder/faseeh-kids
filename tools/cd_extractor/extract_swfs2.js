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

// Search for CWS and FWS
while ((offset = buf.indexOf(Buffer.from("CWS"), offset)) !== -1) {
  const version = buf.readUInt8(offset + 3);
  const uncompLen = buf.readUInt32LE(offset + 4);
  
  if (version >= 4 && version <= 30 && uncompLen > 1000 && uncompLen < 100 * 1024 * 1024) {
    // Try streaming inflate to discover exact compressed length
    const compressedSlice = buf.subarray(offset + 8);
    
    // We can use zlib inflate stream
    const inflator = zlib.createInflate();
    const chunks = [];
    let decompressedLen = 0;
    let bytesConsumed = 0;
    let done = false;

    // Use synchronous inflate or custom wrapper
    // In Node.js zlib stream:
    inflator.on("data", chunk => {
      chunks.push(chunk);
      decompressedLen += chunk.length;
    });

    inflator.on("error", err => {
      // ignore
    });

    // Write slice
    inflator.write(compressedSlice);
    inflator.end();

    const decompressed = Buffer.concat(chunks);
    if (decompressed.length + 8 === uncompLen) {
      // Valid SWF!
      // In FWS format: "FWS" + version + uncompLen + decompressed data
      const fwsHeader = Buffer.alloc(8);
      fwsHeader.write("FWS", 0, 3, "ascii");
      fwsHeader.writeUInt8(version, 3);
      fwsHeader.writeUInt32LE(uncompLen, 4);
      const fullSwf = Buffer.concat([fwsHeader, decompressed]);

      const fileName = `baa_${String(swfIndex).padStart(2, "0")}_v${version}_${uncompLen}.swf`;
      fs.writeFileSync(path.join(outDir, fileName), fullSwf);
      console.log(`[Extracted SWF ${swfIndex}] ${fileName} (Size: ${fullSwf.length} bytes)`);
      swfIndex++;
    }
  }
  offset += 3;
}

console.log(`\nExtracted ${swfIndex} SWFs.`);
