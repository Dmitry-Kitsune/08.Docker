const express = require('express'); // Импортируем Express
const app = express(); // Создаем приложение
const PORT = 8080; // Определяем порт

// Определяем маршрут по умолчанию
app.get('/', (req, res) => {
  res.send('Hello, World! This is a simple Node.js app.');
});

// Запускаем сервер
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
