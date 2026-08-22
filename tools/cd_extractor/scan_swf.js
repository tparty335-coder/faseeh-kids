const fs = require("fs");
const path = "D:/Education  vol2/مناهج 2026/ص1         ت1/arabic_1Prim_t1_u2l2ب.exe";
console.log("Checking file:", path);

const fd = fs.openSync(path, "r");
const stats = fs.fstatSync(fd);
console.log("File size:", stats.size, "bytes");

const buf = Buffer.alloc(stats.size);
fs.readSync(fd, buf, 0, stats.size, 0);
fs.closeSync(fd);

// Check signatures
const sigs = [
  { name: "CWS (Zlib SWF)", sig: Buffer.from([0x43, 0x57, 0x53]) },
  { name: "FWS (Raw SWF)", sig: Buffer.from([0x46, 0x57, 0x53]) },
  { name: "ZWS (LZMA SWF)", sig: Buffer.from([0x5A, 0x57, 0x53]) },
  { name: "PK.. (ZIP)", sig: Buffer.from([0x50, 0x4B, 0x03, 0x04]) },
  { name: "Rar!", sig: Buffer.from([0x52, 0x61, 0x72, 0x21]) },
  { name: "7z", sig: Buffer.from([0x37, 0x7A, 0xBC, 0xAF, 0x27, 0x1C]) }
];

sigs.forEach(s => {
  let count = 0;
  let pos = 0;
  while ((pos = buf.indexOf(s.sig, pos)) !== -1) {
    count++;
    if (count <= 15) {
      console.log(`Found ${s.name} at offset ${pos} (0x${pos.toString(16)})`);
    }
    pos += s.sig.length;
  }
  if (count > 0) {
    console.log(`Total ${s.name} matches: ${count}`);
  }
});
