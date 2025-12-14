import subprocess
from concurrent.futures import ThreadPoolExecutor, as_completed

URLS = [
    # DOOM (2016)
    "https://www.youtube.com/watch?v=W9GaIbECisQ",  # BFG Division
    "https://www.youtube.com/watch?v=HsLOxbLZMy8",  # At Doom's Gate (2016)
    "https://youtu.be/zZMg9ryeWOw?si=VilYHiQRHEkBm_tK",  # Rip & Tear
    "https://youtu.be/3EPeyOiicvU?si=7WIMDWgkfunJxII8",  # Hellwalker
    "https://youtu.be/XeYGdZSt5l0?si=pimI-xDb90W_u2rY",  # Mastermind
    "https://youtu.be/eH9Xmq8-yOM?si=aII8AqJSZcrBwmOh",  # Cyberdemon
    # DOOM Eternal
    "https://youtu.be/kpnW68Q8ltc?si=O14tX1YZzD-jLnVd",  # The Only Thing They Fear Is You
    "https://youtu.be/Z-71-i1akB0?si=UmEbpIdAPa-PmmnX",  # Meathook
    "https://youtu.be/24W_dmJIqfA?si=f_y4L_KGnZ1prlMT",  # Cultist Base
    "https://youtu.be/vfoj7t7NZkI?si=AfvOLkPREaC07PCR",  # Super Gore Nest
    "https://youtu.be/WFqGIWAsbAQ?si=GU3FPcvxaJUM2Sr8",  # BFG 10K
    "https://youtu.be/wj0ts9gwvbs?si=PEW1vMyp00SHFRXJ",  # The Doom Hunter
    "https://youtu.be/K1IBMXGegC0?si=1pq0CfOfmqF690_1",  # Urdak
    "https://youtu.be/MCHwYEfpNHc?si=TrHsKmbz55HSisiP",  # The Icon of Sin
    # Classic DOOM
    "https://www.youtube.com/watch?v=BSsfjHCFosw",  # E1M1 Original
    "https://youtu.be/PkhCNx-8Qos?si=ZfpEYNL0JH94id7u",  # Doom II – Into Sandy's City
    "https://youtu.be/qURei6svd90?si=bGNo9JTySbkG22OW",  # Running From Evil
]

YTDLP_CMD = [
    "yt-dlp",
    "-x",  # Extract audio only
    "--audio-format", "vorbis",  # OGG Vorbis codec (produces .ogg files)
    "--audio-quality", "0",  # Best quality
    "-o", "%(title)s.%(ext)s",  # Output filename template
    "--no-playlist",  # Only download single video, not playlists
]

def download(url):
    """Download a single video's audio"""
    cmd = YTDLP_CMD + [url]
    try:
        result = subprocess.run(cmd, check=True, capture_output=True, text=True)
        print(f"✓ Downloaded: {url}")
        return True
    except subprocess.CalledProcessError as e:
        print(f"✗ Failed: {url}")
        print(f"  Error: {e.stderr}")
        return False

def main():
    print("Starting DOOM soundtrack downloads...")
    print(f"Total tracks: {len(URLS)}")
    print("-" * 60)
    
    max_workers = 4  # Parallel downloads
    with ThreadPoolExecutor(max_workers=max_workers) as executor:
        futures = {executor.submit(download, url): url for url in URLS}
        
        completed = 0
        failed = 0
        for future in as_completed(futures):
            completed += 1
            if not future.result():
                failed += 1
            print(f"Progress: {completed}/{len(URLS)}")
    
    print("-" * 60)
    print(f"Download complete! Success: {len(URLS) - failed}, Failed: {failed}")

if __name__ == "__main__":
    main()
