
require 'roo'
xlsx = Roo::Excelx.new('./roo-studies.xlsx')

register_sheet = xlsx.sheet('Register')

register_sheet.each_row_streaming(offset: 1) do |row|
  nome = row[0].value
  idade = row[1].value
  cidade = row[2].value
  
  puts "Nome: #{nome}, Idade: #{idade}, Cidade: #{cidade}"
end

game_sheet = xlsx.sheet('Game')

game_sheet.each_row_streaming(offset: 1) do |row|
  jogo = row[0].value
  puts "Jogo: #{jogo}"
end