import sys
print("Python version:", sys.version)
print("Python path:", sys.path)

try:
    import google.generativeai
    print("Successfully imported google.generativeai")
except ImportError as e:
    print("Failed to import:", e)

try:
    import litellm
    print("Successfully imported litellm")
except ImportError as e:
    print("Failed to import:", e)
