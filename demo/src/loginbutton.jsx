export default function GoogleLoginButton() {
  const handleLogin = () => {
    // just redirect to backend endpoint that generates Google OAuth URL
    window.location.href = "http://localhost:8000/auth/google/url";
    console.log('Connected')
  };

  return (
    <div style={{ display: "flex", justifyContent: "center", marginTop: "50px" }}>
      <button
        onClick={handleLogin}
        style={{
          padding: "10px 20px",
          borderRadius: "8px",
          backgroundColor: "#DB4437",
          color: "white",
          fontWeight: "bold",
          border: "none",
          cursor: "pointer",
        }}
      >
        Login with Google
      </button>
    </div>
  );
}
