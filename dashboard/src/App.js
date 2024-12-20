import './App.css';
import { useEffect, useState } from 'react';
import { Auth } from "./components/auth";
import { TeacherDashboard } from "./components/Dashboard/teacherDashboard";

function App() {
  const [teacherData, setTeacherData] = useState(null);
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [answerMap, setAnswerMap] = useState({});
  const [answerContextType, setAnswerContextType] = useState('');
  const [isLoading, setIsLoading] = useState(false); // Loading state

  // Handle successful login
  const handleLoginSuccess = (user) => {
    setTeacherData(user);
    setIsAuthenticated(true);
  };

  // Handle receiving answer map from teacher
  const handleReceiveAnswerMapFromTeacher = (newAnswerMap, answerContextType) => {
    setAnswerMap(newAnswerMap);
    setAnswerContextType(answerContextType);
  };

  return (
    <div className="App">
      {isLoading ? (
        <div>Loading...</div> // Display loading state
      ) : !isAuthenticated ? (
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