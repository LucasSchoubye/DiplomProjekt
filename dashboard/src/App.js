import './App.css';
import { useState } from 'react';
import { Auth } from "./components/auth";
import { Database } from "./components/db";

function App() {
  const [isAuthenticated, setIsAuthenticated] = useState(false);

  const handleLoginSuccess = () => {
    setIsAuthenticated(true);
  };

  return (
    <div  className="App">
      {!isAuthenticated ? (
        <Auth onLoginSuccess={handleLoginSuccess} />
      ) : (
        <Database />
      )}
    </div>
  );
}

export default App;