import './App.css';
import { useEffect, useState } from 'react';
import { Auth } from "./components/auth";
import { TeacherDashboard } from "./components/Dashboard/teacherDashboard"
import { Database } from "./components/db (unused)";

function App() {
  const [teacherData, setTeacherData] = useState(null);
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [answerMap, setAnswerMap] = useState({});

  const handleLoginSuccess = (user) => {
    setTeacherData(user)
    setIsAuthenticated(true);
  };

  const handleReceiveAnswerMapFromTeacher = (newAnswerMap) => {
    setAnswerMap(newAnswerMap); // Store the received answerMap
};

useEffect(() => {
  if (Object.keys(answerMap).length > 0) {
    console.log("New answerMap:", answerMap);
  }
}, [answerMap]);

  return (
    <div  className="App">
      {!isAuthenticated ? (
        <Auth onLoginSuccess={handleLoginSuccess} />
      ) : (
        <TeacherDashboard 
        userData={teacherData}
        handleReceiveAnswerMap={handleReceiveAnswerMapFromTeacher}
        />
      )}
    </div>
  );
}

export default App;