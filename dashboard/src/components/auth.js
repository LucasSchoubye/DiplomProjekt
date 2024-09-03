import { auth} from "../config/firebase"
import { signInWithEmailAndPassword, createUserWithEmailAndPassword, signOut } from 'firebase/auth';
import { useState} from "react";
import Button from '@mui/material/Button';
import TextField from '@mui/material/TextField';

export const Auth = () => {

    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");

    console.log(auth?.currentUser?.email);

    const signIn = async () => {
        try {
            await signInWithEmailAndPassword(auth, email, password);    
        } catch (err) {
            console.error(err);
            if(err){
                
            }
        }
    }

    const signUp = async () => {
        try {
            await createUserWithEmailAndPassword(auth, email, password);    
        } catch (err) {
            console.error(err);
        }
    }

    const logOut = async () => {
        try {
            await signOut(auth);    
        } catch (err) {
            console.error(err);
        }
    }

    return <div> 
        <TextField id="outlined-basic" label="Email" variant="outlined" 
        input placeholder="Email..." 
        onChange={(inputEvent) => setEmail(inputEvent.target.value)}/>
        
        <TextField id="outlined-basic" label="Password" variant="outlined" 
        placeholder="Password..." 
        type = "password"
        onChange={(inputEvent) => setPassword(inputEvent.target.value)}/>
        <Button variant = "contained" onClick={signIn}> Sign In</Button>
        <Button variant = "contained" onClick={signUp}> Sign Up</Button>
        <Button variant = "contained" onClick={logOut}> Log Out</Button>
    </div>
}