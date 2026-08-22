const fs = require("fs");
const exePath = "D:/Education  vol2/مناهج 2026/ص1         ت1/arabic_1Prim_t1_u2l2ب.exe";
const buf = fs.readFileSync(exePath);

// Check first 1MB for packaging indicators
const headStr = buf.subarray(0, 500000).toString("latin1");
console.log("Checking packaging indicators:");
if (headStr.includes("Nullsoft")) console.log("Found NSIS!");
if (headStr.includes("Inno Setup")) console.log("Found Inno Setup!");
if (headStr.includes("Wise Setup")) console.log("Found Wise Setup!");
if (headStr.includes("WinRAR")) console.log("Found WinRAR SFX!");
if (headStr.includes("InstallShield")) console.log("Found InstallShield!");
if (headStr.includes("Macromedia Flash")) console.log("Found Macromedia Flash Projector!");
if (headStr.includes("Adobe Flash")) console.log("Found Adobe Flash Projector!");
if (headStr.includes("Zinc")) console.log("Found MDM Zinc!");
if (headStr.includes("SWF Studio")) console.log("Found SWF Studio!");

// Let's check sections in PE
const peOffset = buf.readUInt32LE(0x3C);
console.log("PE header at:", peOffset.toString(16));
const numSections = buf.readUInt16LE(peOffset + 6);
console.log("Number of sections:", numSections);

const optHeaderSize = buf.readUInt16LE(peOffset + 20);
let sectionTableOffset = peOffset + 24 + optHeaderSize;

for (let i = 0; i < numSections; i++) {
  const name = buf.toString("ascii", sectionTableOffset, sectionTableOffset + 8).replace(/\0/g, "");
  const vSize = buf.readUInt32LE(sectionTableOffset + 8);
  const rawSize = buf.readUInt32LE(sectionTableOffset + 16);
  const rawOffset = buf.readUInt32LE(sectionTableOffset + 20);
  console.log(`Section ${i}: ${name} (rawOffset: 0x${rawOffset.toString(16)}, rawSize: ${rawSize})`);
  sectionTableOffset += 40;
}

const lastSectionEnd = buf.readUInt32LE(sectionTableOffset - 40 + 20) + buf.readUInt32LE(sectionTableOffset - 40 + 16);
console.log("End of PE image on disk: 0x" + lastSectionEnd.toString(16), `(${lastSectionEnd} bytes)`);
console.log("Overlay size appended after PE:", buf.length - lastSectionEnd, "bytes");
