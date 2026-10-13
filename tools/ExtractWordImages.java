import java.awt.*;
import java.awt.image.*;
import java.io.*;
import javax.imageio.*;

/**
 * Extracts clean word illustration images from full SWF scene frames.
 * Crops the illustration area (the "tree hollow" content zone) from the full 800x600 scene.
 * Output is a cropped PNG with transparent padding, on white background for clarity.
 */
public class ExtractWordImages {

    public static void main(String[] args) throws Exception {

        // ── BAB (door) ──────────────────────────────────────────────
        // The door sits in the hollow: roughly x=295–435, y=100–380 in the 800x600 frame
        extract(
            "scratch/bab_frames/57.png",
            "assets/images/lessons/baa/sounds/bab.png",
            285, 95, 165, 285,   // x, y, width, height  (crop from scene)
            309, 330             // target output size
        );

        // ── BINT (girl) ─────────────────────────────────────────────
        // The girl sits roughly x=295–450, y=80–380 in the 800x600 frame
        extract(
            "scratch/bent2_frames/57.png",
            "assets/images/lessons/baa/sounds/bint.png",
            280, 75, 185, 305,   // x, y, width, height
            309, 330             // target output size
        );

        System.out.println("Done.");
    }

    static void extract(String src, String dst,
                        int cropX, int cropY, int cropW, int cropH,
                        int outW, int outH) throws Exception {
        BufferedImage scene = ImageIO.read(new File(src));

        // Safety clamps
        cropX = Math.max(0, Math.min(cropX, scene.getWidth() - 1));
        cropY = Math.max(0, Math.min(cropY, scene.getHeight() - 1));
        cropW = Math.min(cropW, scene.getWidth()  - cropX);
        cropH = Math.min(cropH, scene.getHeight() - cropY);

        BufferedImage cropped = scene.getSubimage(cropX, cropY, cropW, cropH);

        // Scale to standard output size
        BufferedImage out = new BufferedImage(outW, outH, BufferedImage.TYPE_INT_ARGB);
        Graphics2D g = out.createGraphics();
        g.setRenderingHint(RenderingHints.KEY_ANTIALIASING,  RenderingHints.VALUE_ANTIALIAS_ON);
        g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BICUBIC);
        g.setRenderingHint(RenderingHints.KEY_RENDERING,     RenderingHints.VALUE_RENDER_QUALITY);
        g.drawImage(cropped, 0, 0, outW, outH, null);
        g.dispose();

        File outFile = new File(dst);
        ImageIO.write(out, "png", outFile);
        System.out.println("Saved: " + outFile.getAbsolutePath() + "  (" + outW + "x" + outH + ")");
    }
}
