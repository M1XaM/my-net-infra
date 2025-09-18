import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import GoogleLoginButton from "./loginbutton";
import GoogleCallback from "./loginCallback";

export default function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<GoogleLoginButton />} />
        <Route path="/auth/google" element={<GoogleCallback />} />
      </Routes>
    </Router>
  );
}
