import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.File;
import javax.imageio.ImageIO;

public class CompositeBorg {
    public static void main(String[] args) throws Exception {
        BufferedImage tower = ImageIO.read(new File("scratch/borg_shapes_png/278.png"));
        BufferedImage wordOutline = ImageIO.read(new File("scratch/borg_shapes_png/276.png"));
        BufferedImage bu = ImageIO.read(new File("scratch/borg_shapes_png/274.png"));

        int width = 309;
        int height = 330;
        BufferedImage composite = new BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB);
        Graphics2D g = composite.createGraphics();
        g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);

        int towerX = (width - tower.getWidth()) / 2;
        int towerY = 15;
        g.drawImage(tower, towerX, towerY, null);

        int wordX = (width - wordOutline.getWidth()) / 2;
        int wordY = towerY + tower.getHeight() + 15;

        // Fill word background with white/pinkish
        g.setColor(new Color(253, 235, 245));
        g.fillRoundRect(wordX + 6, wordY + 8, wordOutline.getWidth() - 12, wordOutline.getHeight() - 12, 12, 12);

        // Draw outline
        g.drawImage(wordOutline, wordX, wordY, null);

        // Draw the purple بُـ
        int buX = wordX + wordOutline.getWidth() - bu.getWidth() - 24;
        int buY = wordY - 6;
        g.drawImage(bu, buX, buY, null);

        g.dispose();

        ImageIO.write(composite, "png", new File("assets/images/lessons/baa/sounds/borg.png"));
        System.out.println("borg.png adjusted successfully!");
    }
}
