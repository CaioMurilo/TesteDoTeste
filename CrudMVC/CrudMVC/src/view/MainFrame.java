package view;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class MainFrame extends JFrame {

    public MainFrame() {
        setTitle("Gerenciador de Estoque");
        setSize(600, 400);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);

        JMenuBar menuBar = new JMenuBar();

        // Menu Produto
        JMenu menuProduto = new JMenu("Produto");
        JMenuItem itemCadastrarProduto = new JMenuItem("Cadastrar Produto");
        itemCadastrarProduto.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                new ProdutoView().setVisible(true);
            }
        });
        menuProduto.add(itemCadastrarProduto);

        // Menu Categoria
        JMenu menuCategoria = new JMenu("Categoria");
        JMenuItem itemCadastrarCategoria = new JMenuItem("Cadastrar Categoria");
        itemCadastrarCategoria.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                new CategoriaView().setVisible(true);
            }
        });
        menuCategoria.add(itemCadastrarCategoria);

        menuBar.add(menuProduto);
        menuBar.add(menuCategoria);

        setJMenuBar(menuBar);
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            MainFrame frame = new MainFrame();
            frame.setVisible(true);
        });
    }
}
