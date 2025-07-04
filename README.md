# 🎬 MovieApp

Um aplicativo iOS moderno para explorar e descobrir filmes, construído com Swift e arquitetura modular.

## ✨ Características

- 🎯 **Arquitetura Modular**: Organizado em módulos independentes usando Swift Package Manager
- 📱 **Interface Nativa**: Desenvolvido com SwiftUI para uma experiência fluida
- 🗂️ **Catálogo de Filmes**: Explore uma vasta coleção de filmes
- ❤️ **Favoritos**: Salve seus filmes preferidos para acesso rápido
- 🧭 **Navegação Intuitiva**: Interface de navegação bottom tab clara e responsiva

## 🏗️ Arquitetura

O projeto utiliza uma arquitetura modular com os seguintes módulos:

```
📦 MovieApp
├── 🎬 App/               # Aplicativo principal
├── 🧭 BottomNavigator/   # Sistema de navegação
├── 📚 Catalog/           # Catálogo de filmes
└── ❤️ Favorites/         # Gerenciamento de favoritos
```

## 🚀 Como Executar

### Pré-requisitos

- 📱 Xcode 15.0 ou superior
- 🍎 iOS 17.0 ou superior
- 🔧 Swift 5.9 ou superior

### Passos para executar

1. **Clone o repositório**
   ```bash
   git clone https://github.com/rodrigogmdias/movieapp.git
   cd movieapp
   ```

2. **Abra o projeto no Xcode**
   ```bash
   open App/MovieApp.xcodeproj
   ```

3. **Selecione o simulador ou dispositivo**
   - Escolha seu dispositivo iOS ou simulador preferido

4. **Execute o projeto**
   - Pressione `⌘ + R` ou clique no botão "Run"

## 🧪 Executando Testes

Para executar os testes de todos os módulos:

```bash
# Teste individual de cada módulo
cd Modules/BottomNavigator && swift test
cd Modules/Catalog && swift test
cd Modules/Favorites && swift test
```

Ou execute diretamente pelo Xcode:
- Pressione `⌘ + U` para executar todos os testes

## 📱 Capturas de Tela

> 🚧 Em breve - adicione suas capturas de tela aqui!

## 🛠️ Tecnologias Utilizadas

- **SwiftUI** - Framework de interface do usuário
- **Swift Package Manager** - Gerenciamento de dependências e módulos
- **Xcode** - IDE de desenvolvimento
- **iOS SDK** - Plataforma de desenvolvimento

## 🤝 Como Contribuir

Adoramos contribuições! Aqui está como você pode ajudar:

### 🐛 Reportar Bugs

1. Verifique se o bug já não foi reportado nas [Issues](../../issues)
2. Abra uma nova issue com:
   - Descrição clara do problema
   - Passos para reproduzir
   - Capturas de tela (se aplicável)
   - Informações do dispositivo/simulador

### 💡 Sugerir Melhorias

1. Abra uma issue com o label "enhancement"
2. Descreva sua ideia detalhadamente
3. Explique por que seria útil para o projeto

### 🔧 Contribuir com Código

1. **Fork o projeto**
2. **Crie uma branch para sua feature**
   ```bash
   git checkout -b feature/nova-feature
   ```
3. **Commit suas mudanças**
   ```bash
   git commit -m "✨ Adiciona nova feature incrível"
   ```
4. **Push para a branch**
   ```bash
   git push origin feature/nova-feature
   ```
5. **Abra um Pull Request**

### 📝 Convenções de Commit

Usamos emojis para deixar o histórico mais claro:

- ✨ `:sparkles:` - Nova feature
- 🐛 `:bug:` - Correção de bug
- 📚 `:books:` - Documentação
- 🎨 `:art:` - Melhoria de código/estrutura
- 🔧 `:wrench:` - Configuração
- ✅ `:white_check_mark:` - Testes

## 📋 Roadmap

- [ ] 🔍 Implementar busca de filmes
- [ ] 🎭 Adicionar detalhes dos filmes
- [ ] 🌟 Sistema de avaliações
- [ ] 🔄 Sincronização com API externa
- [ ] 🌙 Modo escuro
- [ ] 📱 Suporte ao iPad

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 👥 Autores

- **Rodrigo Dias** - *Desenvolvedor Principal* - [@rodrigogmdias](https://github.com/rodrigogmdias)

**Gostou do projeto? Deixe uma ⭐ se este repositório te ajudou!**

## 📞 Suporte

Tem alguma dúvida? Entre em contato:

- 📧 Email: rodrigogmdias@gmail.com
- � GitHub: [@rodrigogmdias](https://github.com/rodrigogmdias)

---

<p align="center">
  Feito com ❤️ e muito ☕ por <a href="https://github.com/rodrigogmdias">Rodrigo Dias</a>
</p>
