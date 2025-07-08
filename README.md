# 🎬 MovieApp

Um app iOS de catálogo de filmes desenvolvido em SwiftUI com arquitetura modular e Clean Architecture.

## 📱 Funcionalidades

- 🏠 **Catálogo de filmes** - Explore filmes populares e mais bem avaliados
- 🔍 **Busca** - Encontre filmes por título
- ❤️ **Favoritos** - Salve seus filmes favoritos
- 📖 **Detalhes** - Veja informações detalhadas dos filmes
- 🧭 **Navegação** - Interface com tabs para fácil navegação

## 🏗️ Arquitetura

O projeto utiliza uma arquitetura modular baseada em Clean Architecture e VIP:

### 📦 Módulos

#### Commons
- **Network** - Serviços de rede e comunicação com APIs
- **Components** - Componentes reutilizáveis de UI
- **Session** - Gerenciamento de sessão do usuário
- **SharedPreferences** - Armazenamento local de preferências

#### Features
- **BottomNavigator** - Navegação principal com tabs
- **Catalog** - Listagem e busca de filmes
- **Favorites** - Gerenciamento de filmes favoritos
- **MovieDetail** - Detalhes dos filmes

### 🎯 Padrões Utilizados
- **VIP** - View, Interactor, Presenter
- **Swift Package Manager** - Gerenciamento de dependências
- **SwiftUI** - Interface do usuário
- **Combine** - Programação reativa
- **Async/Await** - Operações assíncronas

## 🚀 Como Executar

### Pré-requisitos
- Xcode 15.0+
- iOS 16.0+
- macOS 13.0+

### Passos
1. Clone o repositório
2. Abra o projeto `App/MovieApp.xcodeproj` no Xcode
3. Selecione o simulador ou device
4. Execute o projeto (⌘ + R)

## 🧪 Testes

Execute os testes de todos os módulos:

```bash
# No diretório raiz do projeto
xcodebuild test -workspace App/MovieApp.xcodeproj/project.xcworkspace -scheme MovieApp -destination 'platform=iOS Simulator,name=iPhone 15'
```

## 🤝 Como Contribuir

1. 🍴 Faça um fork do projeto
2. 🌟 Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. 💾 Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. 📤 Push para a branch (`git push origin feature/AmazingFeature`)
5. 🔄 Abra um Pull Request

### 📝 Diretrizes
- Mantenha a arquitetura modular
- Adicione testes para novas funcionalidades
- Siga as convenções de código Swift
- Use commits descritivos

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

