import './App.css';
import { useState } from 'react';
import { Auth } from "./components/auth";
import { TeacherDashboard } from "./components/Dashboard/TeacherDashabord"
import { Database } from "./components/db (unused)";

function App() {
  const [teacherData, setTeacherData] = useState(null);
  const [isAuthenticated, setIsAuthenticated] = useState(false);

  const handleLoginSuccess = (user) => {
    setTeacherData(user)
    setIsAuthenticated(true);
  };

  return (
    <div  className="App">
      {!isAuthenticated ? (
        <Auth onLoginSuccess={handleLoginSuccess} />
      ) : (
        <TeacherDashboard userData={teacherData}/>
      )}
    </div>
  );
}

export default App;