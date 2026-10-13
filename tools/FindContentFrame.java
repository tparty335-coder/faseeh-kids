import java.awt.image.*;
import java.io.*;
import javax.imageio.*;
import java.util.*;

/** Scans all frames in a directory and reports which frames have colored content
    in the tree hollow area (approx x=200-550, y=100-380 at 800x600). */
public class FindContentFrame {
    public static void main(String[] args) throws Exception {
        // Tree hollow region (approx at 800x600)
        int rx = 200, ry = 100, rw = 350, rh = 280;

        String[] dirs = {
            "scratch/betekh_frames",
            "scratch/ebra2_frames",
        };

        for (String dir : dirs) {
            System.out.println("\n=== " + dir + " ===");
            File[] pngs = new File(dir).listFiles((d,n)->n.endsWith(".png"));
            if (pngs == null) { System.out.println("not found"); continue; }
            Arrays.sort(pngs, (a,b)->Integer.compare(num(a.getName()),num(b.getName())));

            // Print top 10 frames by color count in hollow
            List<int[]> results = new ArrayList<>();
            for (File f : pngs) {
                BufferedImage img = ImageIO.read(f);
                if (img == null) continue;
                int w = img.getWidth(), h = img.getHeight();
                int ex = Math.min(rx+rw, w), ey = Math.min(ry+rh, h);
                int colored = 0;
                for (int y = ry; y < ey; y += 2) {
                    for (int x = rx; x < ex; x += 2) {
                        int rgb = img.getRGB(x,y);
                        int r=(rgb>>16)&0xFF, g=(rgb>>8)&0xFF, b=rgb&0xFF;
                        int mx=Math.max(r,Math.max(g,b)), mn=Math.min(r,Math.min(g,b));
                        if (mx-mn>40 && mx>50 && (r<90||g<90||b<90)) colored++;
                    }
                }
                results.add(new int[]{num(f.getName()), colored});
            }
            results.sort((a,b)->-Integer.compare(a[1],b[1]));
            for (int i = 0; i < Math.min(15, results.size()); i++) {
                System.out.printf("  frame %3d: colorScore=%d%n", results.get(i)[0], results.get(i)[1]);
            }
        }
    }
    static int num(String n) { try { return Integer.parseInt(n.replace(".png","")); } catch(Exception e){return 0;} }
}
