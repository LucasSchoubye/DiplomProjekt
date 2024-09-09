// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
// import { getAuth } from 'firebase/auth';
import { getFirestore } from 'firebase/firestore';

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyDDNbwx_Q8hTUrmZAwgD9oo0WacWKny1rw",
  authDomain: "education-server-24af7.firebaseapp.com",
  projectId: "education-server-24af7",
  storageBucket: "education-server-24af7.appspot.com",
  messagingSenderId: "428431526179",
  appId: "1:428431526179:web:c074e4d5b55e9eb42ae496",
  measurementId: "G-V0ECT2NY0P"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
// export const auth = getAuth(app);
export const db = getFirestore(app);