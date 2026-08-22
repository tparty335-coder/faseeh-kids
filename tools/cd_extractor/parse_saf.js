const fs = require("fs");
const path = require("path");

const exePath = "D:/Education  vol2/مناهج 2026/ص1         ت1/arabic_1Prim_t1_u2l2ب.exe";
const outDir = "D:/Projects/faseeh_kids/scratch/extracted_baa_saf";
fs.mkdirSync(outDir, { recursive: true });

const buf = fs.readFileSync(exePath);
const overlayOffset = 1081344; // 0x108000

console.log("Parsing SAF container starting at 0x" + overlayOffset.toString(16));

let pos = overlayOffset;
const magic = buf.toString("ascii", pos, pos + 3);
console.log("Magic:", magic);

if (magic !== "SAF") {
  console.error("Not a SAF container!");
  process.exit(1);
}

// Let's dump the structure
// Let's write a scanner that finds all embedded files
// In SAF, files have names in UTF-16LE or ASCII, followed by size and data
// Or let's inspect the first 2048 bytes of the SAF header
console.log("SAF header dump (hex & string):");
for (let i = 0; i < 2048; i += 64) {
  const slice = buf.subarray(pos + i, pos + i + 64);
  const hex = slice.toString("hex");
  const utf16 = slice.toString("utf16le").replace(/[^\x20-\x7E\u0600-\u06FF]/g, ".");
  console.log(`+0x${i.toString(16).padStart(4, "0")}: ${utf16}`);
}
