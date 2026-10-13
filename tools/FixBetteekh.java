import java.awt.image.*;
import java.io.*;
import javax.imageio.*;

public class FixBetteekh {
    public static void main(String[] args) throws Exception {
        // Frame 240: watermelon clearly in hollow, no sparkle effect, "بطيخ" text visible
        // Title "أصوات الحرف" at top — keep it (matches other scenes like baqara)
        // Remove only the CD nav bar (top 36px)
        String src = "scratch/betekh_frames/240.png";
        String dst = "assets/images/lessons/baa/sounds/betteekh.png";
        
        BufferedImage img = ImageIO.read(new File(src));
        int w = img.getWidth(), h = img.getHeight();
        int topCrop = 36; // remove nav bar only
        BufferedImage cropped = img.getSubimage(0, topCrop, w, h - topCrop);
        ImageIO.write(cropped, "png", new File(dst));
        System.out.printf("[OK] betteekh.png: %dx%d -> %dx%d%n", w, h, w, h - topCrop);
    }
}
