<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daily Inspiration</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Add Three.js and GSAP for enhanced animations -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r134/three.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/gsap@3.12.2/dist/gsap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/three@0.134.0/examples/js/controls/OrbitControls.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/three@0.134.0/examples/js/loaders/GLTFLoader.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Raleway:wght@300;400;500;600;700&family=Merriweather:ital,wght@0,400;0,700;1,400&family=Orbitron:wght@400;600;800&display=swap');
        
        :root {
            --bg-color: #121212;
            --text-color: #f5f5f5;
            --primary-color: #4facfe;
            --secondary-color: #00f2fe;
            --accent-color: #f8e8ff;
            --tertiary-color: #ff6e7f;
            --quaternary-color: #bfe9ff;
            --border-color: #2c2c2c;
            --white: #ffffff;
            --card-bg: rgba(22, 22, 26, 0.7);
            --card-border: rgba(255, 255, 255, 0.05);
            --shadow: rgba(0, 0, 0, 0.3);
            --glass: rgba(255, 255, 255, 0.08);
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Raleway', sans-serif;
            background-color: var(--bg-color);
            color: var(--text-color);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow-x: hidden;
            position: relative;
            padding: 0;
            margin: 0;
        }
        
        canvas {
            position: fixed;
            top: 0;
            left: 0;
            z-index: -1;
            width: 100%;
            height: 100%;
        }
        
        .container {
            position: relative;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            width: 100%;
            min-height: 100vh;
            padding: 2rem;
            z-index: 10;
        }
        
        .card {
            position: relative;
            max-width: 800px;
            width: 100%;
            background-color: var(--card-bg);
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 10px 30px var(--shadow);
            backdrop-filter: blur(12px);
            border: 1px solid var(--card-border);
            transition: transform 0.4s cubic-bezier(0.17, 0.67, 0.83, 0.67);
        }
        
        .card:hover {
            transform: translateY(-8px);
        }
        
        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
        }
        
        .card-header {
            position: relative;
            padding: 2.2rem 2rem 1.5rem;
            text-align: center;
            border-bottom: 1px solid var(--glass);
        }
        
        .card-title {
            font-family: 'Merriweather', serif;
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
            letter-spacing: 0.5px;
        }
        
        .card-subtitle {
            font-size: 1rem;
            font-weight: 400;
            color: var(--accent-color);
            letter-spacing: 1.5px;
            text-transform: uppercase;
            opacity: 0.85;
        }
        
        .card-body {
            padding: 2.5rem;
            position: relative;
        }
        
        .quote-content {
            position: relative;
            padding: 1.8rem 2rem;
            background-color: rgba(255, 255, 255, 0.03);
            border-radius: 8px;
            margin-bottom: 1.5rem;
            box-shadow: inset 0 1px 1px rgba(255, 255, 255, 0.05);
            max-height: 400px;
            overflow-y: auto;
            scrollbar-width: thin;
            scrollbar-color: var(--primary-color) rgba(255, 255, 255, 0.05);
        }
        
        .quote-content::-webkit-scrollbar {
            width: 6px;
        }
        
        .quote-content::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 4px;
        }
        
        .quote-content::-webkit-scrollbar-thumb {
            background: var(--primary-color);
            border-radius: 4px;
        }
        
        .quote-text {
            font-family: 'Merriweather', serif;
            font-size: 1.5rem;
            line-height: 1.6;
            font-weight: 400;
            font-style: italic;
            color: var(--white);
            margin-bottom: 1.2rem;
            position: relative;
            transition: font-size 0.3s ease;
        }
        
        .quote-text.medium-length {
            font-size: 1.3rem;
        }
        
        .quote-text.long {
            font-size: 1.1rem;
        }
        
        .quote-text::before {
            content: '"';
            font-family: 'Merriweather', serif;
            font-size: 4rem;
            font-style: normal;
            position: absolute;
            top: -2rem;
            left: -1rem;
            color: var(--primary-color);
            opacity: 0.2;
        }
        
        .quote-author {
            font-size: 1.1rem;
            font-weight: 500;
            text-align: right;
            color: var(--secondary-color);
            margin-right: 1rem;
        }
        
        .quote-author::before {
            content: '—';
            margin-right: 0.5rem;
            color: var(--accent-color);
            opacity: 0.7;
        }
        
        .card-footer {
            padding: 1.5rem 2rem;
            border-top: 1px solid var(--glass);
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        /* Social Icons */
        .social-icons {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-top: 1.5rem;
        }
        
        .social-icon {
            width: 36px;
            height: 36px;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: rgba(255, 255, 255, 0.05);
            border-radius: 50%;
            color: var(--accent-color);
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        
        .social-icon:hover {
            background-color: var(--primary-color);
            color: var(--white);
            transform: translateY(-3px);
        }
        
        /* Loading animation */
        .loader {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: var(--bg-color);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            transition: opacity 0.5s ease, visibility 0.5s ease;
        }
        
        .loader.hidden {
            opacity: 0;
            visibility: hidden;
        }
        
        .darshan-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        
        .darshan-text {
            display: flex;
            justify-content: center;
            margin-top: 20px;
            perspective: 1000px;
        }
        
        .darshan-letter {
            font-family: 'Orbitron', sans-serif;
            font-size: 2.5rem;
            font-weight: 800;
            display: inline-block;
            opacity: 0;
            transform: translateY(20px) rotateX(90deg);
            background: linear-gradient(to right, 
                var(--primary-color), 
                var(--secondary-color), 
                var(--tertiary-color), 
                var(--quaternary-color));
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
            margin: 0 2px;
            text-shadow: 0 0 10px rgba(79, 172, 254, 0.5);
        }
        
        .darshan-letter.active {
            animation: revealLetter 0.5s forwards;
        }
        
        @keyframes revealLetter {
            to {
                opacity: 1;
                transform: translateY(0) rotateX(0);
            }
        }
        
        .darshan-tagline {
            font-family: 'Raleway', sans-serif;
            font-size: 1rem;
            font-weight: 400;
            margin-top: 10px;
            opacity: 0;
            letter-spacing: 3px;
            text-transform: uppercase;
            color: var(--accent-color);
        }
        
        .darshan-tagline.active {
            animation: fadeIn 0.5s forwards;
        }
        
        @keyframes fadeIn {
            to {
                opacity: 0.8;
            }
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .card {
                max-width: 95%;
            }
            
            .card-title {
                font-size: 1.8rem;
            }
            
            .quote-text {
                font-size: 1.25rem;
            }
            
            .quote-text.medium-length {
                font-size: 1.1rem;
            }
            
            .quote-text.long {
                font-size: 0.95rem;
            }
            
            .card-footer {
                flex-direction: column;
                gap: 1.2rem;
            }
            
            .darshan-letter {
                font-size: 2rem;
            }
        }
    </style>
    <script>
        // First priority: Display the DARSHAN text letter by letter
        document.addEventListener('DOMContentLoaded', function() {
            const darshanSequence = startDarshanAnimation();
            
            // Ensure the Darshan animation completes before loading resources
            darshanSequence.then(() => {
                // Now that Darshan animation is complete, start loading resources
                loadResources();
            });
        });

        // Function to animate the Darshan text letter by letter
        function startDarshanAnimation() {
            return new Promise((resolve) => {
                const letters = document.querySelectorAll('.darshan-letter');
                const tagline = document.getElementById('darshan-tagline');
                let delay = 100; // Initial delay
                
                // Animate each letter with increasing delay
                letters.forEach((letter, index) => {
                    setTimeout(() => {
                        letter.classList.add('active');
                        
                        // If this is the last letter, show the tagline after a short delay
                        if (index === letters.length - 1) {
                            setTimeout(() => {
                                tagline.classList.add('active');
                                
                                // Wait for tagline animation to complete before resolving
                                setTimeout(() => {
                                    resolve();
                                }, 800); // Tagline animation time
                            }, 300); // Delay before tagline animation
                        }
                    }, delay);
                    
                    delay += 150; // Add delay for next letter
                });
            });
        }

        // Function to load resources and show content (without progress tracking)
        function loadResources() {
            // Start loading the external resources
            loadExternalScripts().then(() => {
                // Once all scripts are loaded, show the content
                showMainContent();
            });
        }

        // Function to load all required scripts
        function loadExternalScripts() {
            return new Promise((resolve) => {
                const scripts = [
                    'https://cdnjs.cloudflare.com/ajax/libs/three.js/r134/three.min.js',
                    'https://cdn.jsdelivr.net/npm/gsap@3.12.2/dist/gsap.min.js',
                    'https://cdn.jsdelivr.net/npm/three@0.134.0/examples/js/controls/OrbitControls.js',
                    'https://cdn.jsdelivr.net/npm/three@0.134.0/examples/js/loaders/GLTFLoader.js'
                ];
                
                let loaded = 0;
                
                scripts.forEach(src => {
                    const script = document.createElement('script');
                    script.src = src;
                    script.onload = () => {
                        loaded++;
                        if (loaded === scripts.length) {
                            resolve();
                        }
                    };
                    document.head.appendChild(script);
                });
                
                // If there are no scripts, resolve immediately
                if (scripts.length === 0) {
                    resolve();
                }
            });
        }

        // Function to show main content and set up the application
        function showMainContent() {
            // Hide loader with a delay to ensure smooth transition
            setTimeout(() => {
                document.querySelector('.loader').classList.add('hidden');
            }, 200);
            
            // Show main content
            const mainContent = document.getElementById('main-content');
            mainContent.style.display = 'block';
            
            // Initialize Three.js background
            initThreeBackground();
            
            // Process quote text
            processQuote();
        }
        
        // Process quote to separate author and adjust size based on length
        function processQuote() {
            const quoteElement = document.getElementById('quote-text');
            if (!quoteElement) return; // Safety check
            
            const quoteText = quoteElement.textContent;
            
            // Check if the quote has author section (indicated by " — ")
            if (quoteText.includes(' — ')) {
                const parts = quoteText.split(' — ');
                const quote = parts[0];
                const author = parts[1];
                
                // Update the DOM with separate quote and author
                quoteElement.textContent = quote;
                
                // Create and append author element
                const authorElement = document.createElement('p');
                authorElement.className = 'quote-author';
                authorElement.textContent = author;
                quoteElement.after(authorElement);
                
                // Adjust font size based on quote length
                adjustQuoteSize(quoteElement, quote);
            } else {
                // If no author separator is found, still adjust the quote size
                adjustQuoteSize(quoteElement, quoteText);
            }
        }
        
        // Function to adjust quote size based on text length
        function adjustQuoteSize(quoteElement, text) {
            // Remove any existing size classes
            quoteElement.classList.remove('medium-length', 'long');
            
            // Determine size class based on character count
            const length = text.length;
            
            if (length > 300) {
                quoteElement.classList.add('long');
            } else if (length > 150) {
                quoteElement.classList.add('medium-length');
            }
            
            // Check if the quote is still overflowing
            const quoteContainer = document.querySelector('.quote-content');
            if (quoteContainer) {
                // If quote is too long, make sure scroll is visible and working
                if (quoteContainer.scrollHeight > quoteContainer.clientHeight) {
                    // Add a subtle indication that content is scrollable
                    const scrollIndicator = document.createElement('div');
                    scrollIndicator.className = 'scroll-indicator';
                    scrollIndicator.innerHTML = '<i class="fas fa-chevron-down"></i>';
                    scrollIndicator.style.cssText = `
                        position: absolute;
                        bottom: 10px;
                        left: 50%;
                        transform: translateX(-50%);
                        color: var(--primary-color);
                        opacity: 0.7;
                        font-size: 1.2rem;
                        animation: pulse 1.5s infinite;
                    `;
                    
                    // Add keyframes for the pulse animation
                    if (!document.getElementById('scroll-indicator-style')) {
                        const style = document.createElement('style');
                        style.id = 'scroll-indicator-style';
                        style.textContent = `
                            @keyframes pulse {
                                0% { opacity: 0.4; transform: translate(-50%, 0); }
                                50% { opacity: 0.7; transform: translate(-50%, 5px); }
                                100% { opacity: 0.4; transform: translate(-50%, 0); }
                            }
                        `;
                        document.head.appendChild(style);
                    }
                    
                    // Only add the indicator if it doesn't already exist
                    if (!document.querySelector('.scroll-indicator')) {
                        quoteContainer.appendChild(scrollIndicator);
                        
                        // Remove the indicator when user scrolls
                        quoteContainer.addEventListener('scroll', function() {
                            const indicator = document.querySelector('.scroll-indicator');
                            if (indicator && this.scrollTop > 30) {
                                indicator.style.opacity = '0';
                                setTimeout(() => {
                                    indicator.remove();
                                }, 300);
                            }
                        });
                    }
                }
            }
        }
        
        // Initialize Three.js background
        function initThreeBackground() {
            const canvas = document.getElementById('bg-canvas');
            if (!canvas) return; // Safety check
            
            if (!window.THREE) {
                console.error('THREE.js not loaded yet');
                return;
            }
            
            // Create scene, camera, renderer
            const scene = new THREE.Scene();
            const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
            const renderer = new THREE.WebGLRenderer({ 
                canvas: canvas,
                antialias: true,
                alpha: true
            });
            
            renderer.setSize(window.innerWidth, window.innerHeight);
            renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
            
            // Add particles
            const particlesGeometry = new THREE.BufferGeometry();
            const particlesCount = 5000;
            
            const posArray = new Float32Array(particlesCount * 3);
            const colorsArray = new Float32Array(particlesCount * 3);
            
            for (let i = 0; i < particlesCount * 3; i++) {
                // Position
                posArray[i] = (Math.random() - 0.5) * 10;
                
                // Colors - changed to match the new blue theme
                if (i % 3 === 0) {
                    // R
                    colorsArray[i] = 0.1 + Math.random() * 0.2; // Blue-ish
                } else if (i % 3 === 1) {
                    // G
                    colorsArray[i] = 0.7 + Math.random() * 0.3;
                } else {
                    // B
                    colorsArray[i] = 0.8 + Math.random() * 0.2;
                }
            }
            
            particlesGeometry.setAttribute('position', new THREE.BufferAttribute(posArray, 3));
            particlesGeometry.setAttribute('color', new THREE.BufferAttribute(colorsArray, 3));
            
            const particlesMaterial = new THREE.PointsMaterial({
                size: 0.02,
                transparent: true,
                opacity: 0.8,
                vertexColors: true,
                blending: THREE.AdditiveBlending
            });
            
            const particlesMesh = new THREE.Points(particlesGeometry, particlesMaterial);
            scene.add(particlesMesh);
            
            // Add lights
            const ambientLight = new THREE.AmbientLight(0x404040, 0.5);
            scene.add(ambientLight);
            
            const directionalLight = new THREE.DirectionalLight(0x4facfe, 1);
            directionalLight.position.set(1, 1, 1);
            scene.add(directionalLight);
            
            // Set camera position
            camera.position.z = 4;
            
            // Mouse effects
            let mouseX = 0;
            let mouseY = 0;
            
            function onDocumentMouseMove(event) {
                mouseX = (event.clientX - window.innerWidth / 2) / 100;
                mouseY = (event.clientY - window.innerHeight / 2) / 100;
            }
            
            document.addEventListener('mousemove', onDocumentMouseMove);
            
            // Handle window resize
            window.addEventListener('resize', () => {
                camera.aspect = window.innerWidth / window.innerHeight;
                camera.updateProjectionMatrix();
                renderer.setSize(window.innerWidth, window.innerHeight);
                renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
            });
            
            // Animation loop
            function animate() {
                requestAnimationFrame(animate);
                
                // Rotate particles
                particlesMesh.rotation.x += 0.0003;
                particlesMesh.rotation.y += 0.0004;
                
                // Mouse effects
                particlesMesh.rotation.x += mouseY * 0.0003;
                particlesMesh.rotation.y += mouseX * 0.0003;
                
                renderer.render(scene, camera);
            }
            
            animate();
        }
    </script>
</head>
<body>
    <!-- Loading screen - simplified without progress bar -->
    <div class="loader">
        <div class="darshan-container">
            <div class="darshan-text" id="darshan-text">
                <span class="darshan-letter">D</span>
                <span class="darshan-letter">A</span>
                <span class="darshan-letter">R</span>
                <span class="darshan-letter">S</span>
                <span class="darshan-letter">H</span>
                <span class="darshan-letter">A</span>
                <span class="darshan-letter">N</span>
            </div>
            <div class="darshan-tagline" id="darshan-tagline">Wisdom In Every Glance</div>
        </div>
    </div>

    <!-- Main content placeholder - will be loaded after Darshan animation -->
    <div id="main-content" style="display:none;">
        <!-- Three.js Canvas -->
        <canvas id="bg-canvas"></canvas>
        
        <div class="container">
            <div class="card">
                <div class="card-header">
                    <h1 class="card-title">Daily Inspiration</h1>
                    <p class="card-subtitle">Wisdom for your journey</p>
                    
                    <div class="social-icons">
                        <a href="https://www.instagram.com/darshan.vs_" class="social-icon"><i class="fab fa-instagram"></i></a>
                        <a href="https://www.linkedin.com/in/darshan-sarvaiya/" class="social-icon"><i class="fab fa-linkedin-in"></i></a>
                        <a href="https://www.github.com/drsnvs" class="social-icon"><i class="fab fa-github"></i></a>
                        <a href="https://www.drsnvs.me" class="social-icon"><i class="fas fa-external-link-alt"></i></a>
                    </div>
                </div>
                
                <div class="card-body">
                    <div class="quote-content">
                        <p class="quote-text" id="quote-text">${quote}</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Load Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</body>
</html> 