# Registo de trabalho

Página estática (HTML + JavaScript) que regista o código de barras lido por foto, com data, hora e utilizador, numa base de dados Supabase, e exporta tudo em CSV. Funciona em GitHub Pages, Vercel, Netlify ou qualquer alojamento estático, sem build.

## 1. Base de dados (Supabase, plano gratuito)
1. Criar um projeto em https://supabase.com.
2. Em **SQL Editor**, colar e executar o conteúdo de `supabase.sql`.
3. Em **Project Settings > API**, copiar o **Project URL** e a chave **anon public**.
4. Colar ambos em `config.js`.

## 2. Publicar
**GitHub Pages:** criar um repositório com estes ficheiros, depois **Settings > Pages > Deploy from a branch > main / (root)**.

**Vercel:** importar o repositório em https://vercel.com/new e escolher o preset **Other** (sem build command, output na raiz). Não é preciso mais nada.

A câmara só funciona em HTTPS, que ambos os serviços fornecem.

## 3. Uso
1. Em **Gerir utilizadores**, adicionar os nomes.
2. Escolher o utilizador, **Tirar foto ao código**, confirmar o código e **Guardar registo**.
3. **Exportar tudo em CSV** gera `codigo_barras;data;hora;utilizador` (separador `;`, UTF-8, hora de Lisboa). A hora é definida pelo servidor.

## Segurança
A chave anon fica visível no código da página. Com as políticas de `supabase.sql`, qualquer pessoa que conheça o endereço da página pode ler e inserir registos (não pode editar nem apagar registos). Para dados sensíveis, restrinja o acesso: proteção por palavra-passe do alojamento (Vercel) ou Supabase Auth, trocando `to anon` por `to authenticated` nas políticas.

## Notas
- O Excel pode mostrar EAN longos em notação científica ou retirar zeros à esquerda: importar a coluna como texto (Dados > De Texto/CSV) ou usar Power BI.
- A leitura usa o `BarcodeDetector` do browser quando existe, com a biblioteca ZXing como alternativa.
