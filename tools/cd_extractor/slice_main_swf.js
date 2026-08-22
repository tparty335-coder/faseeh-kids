const fs = require("fs");
const exePath = "D:/Education  vol2/مناهج 2026/ص1         ت1/arabic_1Prim_t1_u2l2ب.exe";
const buf = fs.readFileSync(exePath);
const offset = 2568705; // 0x273201

console.log("Sig:", buf.toString("ascii", offset, offset + 3));
console.log("Version:", buf.readUInt8(offset + 3));
console.log("Uncompressed Len:", buf.readUInt32LE(offset + 4));

// Save swf
const swfData = buf.subarray(offset);
fs.writeFileSync("D:/Projects/faseeh_kids/scratch/baa_main.swf", swfData);
console.log("Successfully wrote baa_main.swf, size:", swfData.length);
