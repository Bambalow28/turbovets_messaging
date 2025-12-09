class Helpers {
  final Map<String, String> _aiResponses = {
    'help': "I'm here to help! What do you need assistance with?",
    'hello': "Hello! How can I assist you today?",
    'hi': "Hi there! What can I do for you?",
    'how are you': "I'm doing great, thank you for asking! How about you?",
    'bye': "Goodbye! Have a wonderful day!",
    'thanks': "You're welcome! Is there anything else I can help you with?",
    'thank you': "You're welcome! Feel free to ask if you need anything else.",
    'what can you do':
        "I can help you with various things! Just ask me anything and I'll do my best to assist.",
    'weather':
        "I wish I could check the weather for you, but I don't have access to real-time data. Try checking a weather app!",
    'time':
        "I don't have access to the current time, but you can check your device's clock!",
    'joke':
        "Why don't scientists trust atoms? Because they make up everything! 😄",
    'good morning': "Good morning! Hope you have a fantastic day ahead!",
    'good night': "Good night! Sleep well and sweet dreams!",
    'how do i':
        "That's a great question! Could you be more specific about what you're trying to do?",
    'what is':
        "Interesting question! Could you tell me more about what you'd like to know?",
    'recommend':
        "I'd love to help with recommendations! What are you looking for?",
    'problem':
        "I'm sorry to hear you're having a problem. Can you describe it in more detail?",
    'error':
        "Errors can be frustrating! Tell me more about what's happening and I'll try to help.",
    'love': "That's sweet! Spreading positivity is always wonderful! ❤️",
    'bored':
        "Let's fix that! How about we chat about something interesting? What are your hobbies?",
  };

  String getAIResponse(String userMessage) {
    String lowerMessage = userMessage.toLowerCase();

    // Check for keyword matches
    for (var entry in _aiResponses.entries) {
      if (lowerMessage.contains(entry.key)) {
        return entry.value;
      }
    }

    // Default response if no keyword matches
    return "That's interesting! Tell me more about it.";
  }
}
