package view;

import java.awt.EventQueue;
import java.awt.Font;

import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;
import javax.swing.border.EmptyBorder;

import controller.VerQuesitosTableModel;

public class TelaVerQuesito extends JFrame {

	private static final long serialVersionUID = 1L;
	private JPanel contentPane;
	private JTable tabelaVerQuesitos;
	private VerQuesitosTableModel vqtm = new VerQuesitosTableModel();
	private JLabel label;
	
	public static void main(String[] args) {
		try {
			UIManager.setLookAndFeel("javax.swing.plaf.nimbus.NimbusLookAndFeel");
		} catch (ClassNotFoundException e1) {
			e1.printStackTrace();
		} catch (InstantiationException e1) {
			e1.printStackTrace();
		} catch (IllegalAccessException e1) {
			e1.printStackTrace();
		} catch (UnsupportedLookAndFeelException e1) {
			e1.printStackTrace();
		}
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					TelaVerQuesito frame = new TelaVerQuesito(null);
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}
	
	public TelaVerQuesito(String titulo) {
		super("Quesito - " + titulo);
		setBounds(100, 100, 1068, 521);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JScrollPane scrollPane = new JScrollPane();
		scrollPane.setBounds(6, 56, 1048, 432);
		contentPane.add(scrollPane);
		
		tabelaVerQuesitos = new JTable();
		tabelaVerQuesitos.setModel(vqtm);
		tabelaVerQuesitos.setAutoResizeMode(JTable.AUTO_RESIZE_ALL_COLUMNS);
		scrollPane.setViewportView(tabelaVerQuesitos);
		
		JLabel lblQuesitoAtual = new JLabel("Quesito Atual: ");
		lblQuesitoAtual.setFont(new Font("SansSerif", Font.BOLD, 16));
		lblQuesitoAtual.setBounds(26, 18, 144, 16);
		contentPane.add(lblQuesitoAtual);
		
		label = new JLabel(titulo);
		label.setFont(new Font("SansSerif", Font.PLAIN, 15));
		label.setBounds(158, 18, 297, 16);
		contentPane.add(label);
	}
}
