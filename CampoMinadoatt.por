programa{
  inclua biblioteca Util
  inclua biblioteca Texto

  
  cadeia campo[10][10]
  inteiro tamanho = 10, linha, coluna

  funcao inicializarCampo(){
    para(linha = 0; linha < tamanho; linha++){
      para(coluna = 0; coluna < tamanho; coluna++){
        campo[linha][coluna] = "F+0"
      }
    }
  }

  funcao imprimirCampo(){

    escreva("\n\n\t  0   1   2   3   4   5   6   7   8   9\n")
    escreva("\t-----------------------------------------\n")
    para(linha = 0; linha < tamanho; linha++){
      escreva("\t|")
      para(coluna = 0; coluna < tamanho; coluna++){
        se(estaAberta(linha, coluna) == 1){
          se(eBomba(linha, coluna) == 1)
            escreva(" * |")
          senao{
            escreva(" ", Texto.extrair_subtexto(campo[linha][coluna],2,3)," |")
          }
        }
        senao
          escreva("   |")
        se(coluna == tamanho - 1)
          escreva("   ", linha)
      }
      escreva("\n\t-----------------------------------------\n")
    }
  }

  funcao sortearBombas(inteiro quantidade){
    inteiro l, c

    para(linha = 1; linha <= quantidade; linha++){
      l = Util.sorteia(0, tamanho - 1)
      c = Util.sorteia(0, tamanho - 1)
      campo[l][c] = Texto.substituir(campo[l][c], "+", "*")
    }
  }

  funcao inteiro eValida(inteiro l, inteiro c){
    se(l >= 0 e l < tamanho e c >= 0 e c < tamanho)
      retorne 1
    retorne 0
  }

  funcao inteiro eBomba(inteiro l, inteiro c){
    se(eValida(l, c) == 1){
      se(Texto.posicao_texto("*", campo[l][c], 1) != -1)
        retorne 1
      senao
        retorne 0
    }
    retorne 0
  }

  funcao contarBombasVizinhas(){
    inteiro quantidade = 0
    
    para(linha = 0; linha < tamanho; linha++){
      para(coluna = 0; coluna < tamanho; coluna++){
        quantidade += eBomba(linha - 1, coluna)
        quantidade += eBomba(linha + 1, coluna)
        quantidade += eBomba(linha, coluna + 1)
        quantidade += eBomba(linha, coluna - 1)
        campo[linha][coluna] = Texto.substituir(campo[linha][coluna], "0", ""+quantidade)
        quantidade = 0
      }
    }
  }

  funcao inteiro leCoordenada(){
    inteiro x

    leia(x)
    enquanto(x < 0 ou x >= tamanho){
      escreva("\n\tNumero Invalido. Digite um valor entre 0 e ", tamanho -1, ".\n")
      leia(x)
    }
    retorne x
  }

  funcao inteiro estaAberta(inteiro l, inteiro c){
    se(Texto.posicao_texto("A", campo[l][c], 0) != -1)
      retorne 1
    retorne 0
  }

  funcao leCoordenadas(){
    faca{
      escreva("\n\tDigite o numero da Linha:\n")
      linha = leCoordenada()
      escreva("\n\tDigite o numero da Coluna:\n")
      coluna = leCoordenada()

      se(estaAberta(linha, coluna) == 1)
        escreva("\n\tEsta posição já foi usada. Digite outra posição!\n")
    }enquanto(estaAberta(linha, coluna) == 1)
  }

  funcao abrirPosicao(inteiro l, inteiro c){
    se(eValida(l, c) == 1 e estaAberta(l, c) == 0){
      campo[l][c] = Texto.substituir(campo[l][c], "F", "A")
      se(Texto.posicao_texto("0", campo[l][c], 2) != -1){
        abrirPosicao(l - 1, c)
        abrirPosicao(l + 1, c)
        abrirPosicao(l, c + 1)
        abrirPosicao(l, c - 1)
      }
    }
  }

  funcao inteiro Perdeu(inteiro l, inteiro c){
    se(eBomba(l, c) == 1)
      retorne 1
    retorne 0
  }

  funcao inteiro totalFechadas(){
    inteiro quantidade = 0

    para(linha = 0; linha < tamanho; linha++){
      para(coluna = 0; coluna < tamanho; coluna++){
        se(eBomba(linha, coluna) == 0 e estaAberta(linha, coluna) == 0)
          quantidade++
      }
    }
    retorne quantidade
  }

  funcao inteiro Ganhou(inteiro l, inteiro c){
    se(totalFechadas() == 0)
      retorne 1
    retorne 0
  }


  funcao jogar(){
    inteiro perdeu, ganhou

    faca{
      imprimirCampo()
      leCoordenadas()
      abrirPosicao(linha, coluna)
      perdeu = Perdeu(linha, coluna)
      ganhou = Ganhou(linha, coluna)
    }enquanto(perdeu == 0 e ganhou == 0)

    se(perdeu == 1)
      escreva("\n\tVocê perdeu!\n")
    se(ganhou == 1)
      escreva("\n\tVOCÊ GANHOU!\n")
  }
  

  funcao inicio(){
    inteiro opcao

    faca{
      inicializarCampo()
      sortearBombas(10)
      contarBombasVizinhas()
      jogar()

      escreva("\n\tDigite 1 para jogar novamente: \n")
      leia(opcao)
    }enquanto(opcao == 1)
  }
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 3993; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */