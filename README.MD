# Blackjack State Machine

Este projeto implementa uma máquina de estado para o jogo Blackjack (21) em Verilog. A máquina de estado simula o jogo entre um jogador e a banca, seguindo as regras tradicionais do Blackjack.

## Estrutura do Projeto

O projeto está organizado da seguinte forma:

```
./
├── docs/
└── src/
├── main.v
└── modules/
├── blackJackStateMachine.v
├── memoryRam.v
└── shuffleCards.v
```


- A pasta `docs/` contém a documentação relacionada ao projeto.
- A pasta `src/` contém os arquivos de código-fonte do projeto.
- O arquivo `main.v` é o módulo principal que instancia a máquina de estado e outros módulos necessários.
- A pasta `modules/` contém os módulos auxiliares utilizados na implementação da máquina de estado, incluindo a RAM de memória e o embaralhamento das cartas.

## Compilação e Execução

1. Certifique-se de ter um compilador Verilog/SystemVerilog instalado e configurado em seu ambiente de desenvolvimento.
2. Navegue até a pasta `src/` do projeto.
3. Execute o comando de compilação para compilar todos os arquivos `.v` do projeto:

```
$ iverilog -o main *.v
```


Isso irá gerar o arquivo executável `main` a partir dos arquivos `.v`.

4. Execute o arquivo executável gerado para simular o projeto:

```
$ vvp main
```


Isso iniciará a simulação do projeto usando o simulador definido pelo `vvp`.

## Contribuição

Se você deseja contribuir para este projeto, fique à vontade para fazer um fork deste repositório, realizar suas modificações e enviar um pull request.

## Licença

Este projeto está licenciado sob a [Licença MIT](LICENSE).


