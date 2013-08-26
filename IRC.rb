require "socket"

class Bot

	def introduces(server, port, nick, channel, message_prefix, greetings, questions)

		#TCP means message is going to be received
		irc_server = TCPSocket.open(server,port)
		irc_server.puts "USER bVenerin 0 * BVenerin"
		irc_server.puts "NICK #{nick}"
		irc_server.puts "JOIN #{channel}"
		#irc_server.puts "PRIVMSG #{channel} :Hello from IRB Bot"

		until irc_server.eof? do
			msg = irc_server.gets.downcase
			puts msg

			wasGreeted = false

			greetings.each do |g| 
				wasGreeted = true if msg.include? g 
			end

			if msg.include? message_prefix and wasGreeted
				response = "Hey there!"
				irc_server.puts "PRIVMSG #{channel} :#{response}"
			end	

			wasQuestioned = false

			questions.each do |q|
				wasQuestioned = true if msg.include? q
			end

			if msg.include? message_prefix and wasQuestioned
				response = "My name is #{nick} and I exist only to serve :("
				irc_server.puts "PRIVMSG #{channel} :#{response}"
			end	


		end

	end

end

bot = Bot.new
server = "chat.freenode.net"
port = "6667"
nick = "Venerin"
channel = "#bitmaker"
message_prefix = "privmsg #bitmaker :"
greetings = ["hey", "hello", "what's up?", "hi", "yo", "greetings"]
questions = ["who are you", "what do you do"]
bot.introduces(server, port, nick, channel, message_prefix, greetings, questions)

