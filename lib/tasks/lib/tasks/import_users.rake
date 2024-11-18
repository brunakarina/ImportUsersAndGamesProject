require 'roo'

namespace :import do
  desc "Importa usuários e jogos"
  task users_and_games: :environment do
    puts "Importando usuários e jogos"

    xlsx = Roo::Excelx.new('app/services/roo-studies.xlsx')

    game_sheet = xlsx.sheet('Game')
    game_sheet.each_row_streaming(offset: 1) do |row|
      jogo = row[0].value
      puts "Jogo: #{jogo}"

      Game.find_or_create_by(nome: jogo)
    end

    register_sheet = xlsx.sheet('Register')
    register_sheet.each_row_streaming(offset: 1) do |row|
      nome = row[0].value
      idade = row[1].value
      cidade = row[2].value

      User.find_or_create_by(nome: nome, idade: idade, cidade: cidade)
    end

    users_and_games = xlsx.sheet('User_Games')
    users_and_games.each_row_streaming(offset: 1) do |row|
      user_name = row[0].value
      game_name = row[1].value

      user = User.find_by(nome: user_name)
      game = Game.find_by(nome: game_name)

      if user && game
        UserGame.find_or_create_by(user_id: user.id, game_id: game.id)
      else
        puts "Usuário ou jogo não encontrado: #{user_name} - #{game_name}"
      end
    end
  end
end


