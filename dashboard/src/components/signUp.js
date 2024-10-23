import { useState } from "react";
import { TextField, Button, Box, Snackbar, Alert } from "@mui/material";
import { ArrowBack } from "@mui/icons-material";
import { sha512 } from 'js-sha512';
import { collection, query, where, getDocs, setDoc, doc } from "firebase/firestore";
import { db } from "../config/firebase";

const SignUp = ({ onSignUpSuccess, onGoBack }) => {
    const [username, setUsername] = useState("");
    const [password, setPassword] = useState("");
    const [confirmPassword, setConfirmPassword] = useState("");
    const [openSnackbar, setOpenSnackbar] = useState(false);
    const [snackbarMessage, setSnackbarMessage] = useState("");
    const [snackbarSeverity, setSnackbarSeverity] = useState("success");
    const usersCollectionRef = collection(db, "users");

    const handleCloseSnackbar = () => {
        setOpenSnackbar(false);
    };

    const signUp = async () => {
        if (password !== confirmPassword) {
            setSnackbarMessage("Passwords do not match");
            setSnackbarSeverity("error");
            setOpenSnackbar(true);
            return;
        }

        const hashedPassword = sha512(password);
        try {
            const q = query(usersCollectionRef, where("username", "==", username));
            const querySnapshot = await getDocs(q);

            if (!querySnapshot.empty) {
                setSnackbarMessage("The username is taken");
                setSnackbarSeverity("error");
                setOpenSnackbar(true);
                return;
            }

            await setDoc(doc(usersCollectionRef), {
                username: username,
                password: hashedPassword
            });

            setSnackbarMessage("User signed up successfully");
            setSnackbarSeverity("success");
            setOpenSnackbar(true);
            
            setTimeout(() => {
                onSignUpSuccess();
            }, 1000); // 1 second delay
        } catch (err) {
            setSnackbarMessage("Error during sign up: " + err.message);
            setSnackbarSeverity("error");
            setOpenSnackbar(true);
        }
    };

    return (
        <Box
            sx={{
                display: 'flex',
                flexDirection: 'column',
                justifyContent: 'center',
                alignItems: 'center',
                gap: 2,
                padding: 3,
                borderRadius: 2,
                boxShadow: 3,
                width: '300px',
            }}
        >
            <TextField
                label="Username"
                variant="outlined"
                placeholder="Username..."
                fullWidth
                onChange={(inputEvent) => setUsername(inputEvent.target.value)}
            />
            <TextField
                label="Password"
                variant="outlined"
                placeholder="Password..."
                type="password"
                fullWidth
                onChange={(inputEvent) => setPassword(inputEvent.target.value)}
            />
            <TextField
                label="Confirm Password"
                variant="outlined"
                placeholder="Confirm Password..."
                type="password"
                fullWidth
                onChange={(inputEvent) => setConfirmPassword(inputEvent.target.value)}
            />
            <Button variant="contained" onClick={signUp} fullWidth>
                Sign Up
            </Button>

            <Snackbar
                open={openSnackbar}
                autoHideDuration={6000}
                onClose={handleCloseSnackbar}
            >
                <Alert
                    onClose={handleCloseSnackbar}
                    severity={snackbarSeverity}
                    sx={{ width: '100%' }}
                >
                    {snackbarMessage}
                </Alert>
            </Snackbar>
        </Box>
    );
};

export default SignUp;