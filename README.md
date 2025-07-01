# Versionary Collab
Rede social do jogo Versionary

Usuários (/user)
 
Cadastro de Usuário
Endpoint: /users/register
Método: POST
Não requer autorização.
Cria um novo usuário.
Resposta: 201 cadastra o usuário em caso de sucesso, 500 em caso de erro.
Body: { 
                                     “username”: “usuario”,
              “email”: “email@email.com”,
              “senha”: “senha123”,
              “nome”: “nome”
}

Editar Usuário
Endpoint: /users/{id}
Método: PUT
Edita os dados do usuário especificado pelo ID.
Resposta: 201 edita o usuário em caso de sucesso, 500 em caso de erro.
Body: { 
                                     “username”: “novo_usuario”,
              “email”: “novoemail@email.com”,
              “senha”: “novasenha123,”
}

Obter Usuário por ID
Endpoint: /users/{username}
Método: GET
Retorna os dados do usuário pelo username.
Resposta: 200 retorna o usuário em caso de sucesso, 500 em caso de erro.


Autenticação (/auth)
 
Login
Endpoint: /auth/login
Método: POST
Não requer autorização.
Valida as credenciais e retorna token que expira em 1 dia.
Resposta: 200 com o login efetuado em caso de sucesso, 401 e 500 em caso de erro.
Body: {
              “email”: “email@email.com”,
              “senha”: “senha123”,
}

Publicações (/posts)
 
Criar Post
Endpoint: /posts
Método: POST
Cria uma nova publicação.
Resposta: 201 com o post criado em caso de sucesso, 500 em caso de erro.
Body: {
              “titulo”: “Título do post”,
              “conteudo”: “Conteúdo do post”,
}

Feed de Posts
Endpoint: /posts
Método: GET
Não requer autorização.
Retorna o feed de publicações.
Resposta: 200 com a lista de posts em caso de sucesso, 500 em caso de erro.

Detalhes do Post
Endpoint: /posts/{id}
Método: GET
Não requer autorização.
Retorna os detalhes de um post específico.
Resposta: 200 com os detalhes do post em caso de sucesso, 500 em caso de erro.

Editar Post
Endpoint: /posts/{id}
Método: PUT
Edita um post existente.
Resposta: 204 com o post editado em caso de sucesso, 401 e 500 em caso de erro.
Body: {
              “titulo”: “Novo título do post”,
              “conteudo”: “Novo conteúdo do post”,
}

Excluir Post
Endpoint: /posts/{id}
Método: DELETE
Exclui um post existente.
Resposta: 204 com o post deletado em caso de sucesso, 401 e 500 em caso de erro.

Comentários (/posts/{id}/comments)
 
Comentar em uma Publicação
Endpoint: /posts/{id}/comments
Método: POST
Adiciona um comentário à publicação.
Resposta: 201 comentário criado em caso de sucesso, 401 e 500 em caso de erro.
Body: {
              “conteudo”: “Comentário”,
}

Listar Comentários
Endpoint: /posts/{id}/comments
Método: GET
Não requer autorização.
Adiciona um comentário à publicação.
Resposta: 200 lista os comentários em caso de sucesso, 500 em caso de erro.

Editar Comentários
Endpoint: /posts/{id}/comments/{commentId}
Método: PUT
Edita um comentário.
Resposta: 204 lista edita um comentário em caso de sucesso, 401 e 500 em caso de erro.
Body: {
              “conteudo”: “Novo comentário”,
}

Excluir Comentários
Endpoint: /posts/{id}/comments/{commentId}
Método: DELETE
Deleta um comentário.
Resposta: 204 lista deleta um comentário em caso de sucesso, 401 e 500 em caso de erro.



