package model;

public class EscolasDeSamba {

	private int classificacao;
	private String nome;
	private Double total_de_pontos;
	
	public int getClassificacao_escola() {
		return classificacao;
	}
	public void setClassificacao_escola(int classificacao) {
		this.classificacao = classificacao;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public Double getTotal_de_pontos() {
		return total_de_pontos;
	}
	public void setTotal_de_pontos(Double total_de_pontos) {
		this.total_de_pontos = total_de_pontos;
	}	
	
}
