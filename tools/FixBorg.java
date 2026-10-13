import java.awt.image.*;
import java.io.*;
import javax.imageio.*;
public class FixBorg {
    public static void main(String[] a) throws Exception {
        BufferedImage img = ImageIO.read(new File("scratch/borg_frames/220.png"));
        int w = img.getWidth(), h = img.getHeight();
        BufferedImage crop = img.getSubimage(0, 36, w, h - 36);
        ImageIO.write(crop, "png", new File("assets/images/lessons/baa/sounds/borg.png"));
        System.out.printf("[OK] borg.png %dx%d -> %dx%d%n", w, h, w, h-36);
    }
}
