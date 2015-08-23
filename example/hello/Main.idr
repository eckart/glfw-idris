module Main

import Graphics.Util.Glfw
import Graphics.Util.GlfwConfig

initDisplay : String -> Int -> Int -> IO GlfwWindow
initDisplay title width height = do
  glfw <- glfwInit
  glfwWindowHint GLFW_CONTEXT_VERSION_MAJOR  4
  glfwWindowHint GLFW_CONTEXT_VERSION_MINOR  1
  glfwWindowHint GLFW_OPENGL_FORWARD_COMPAT  1
  glfwWindowHint GLFW_OPENGL_PROFILE         (toInt GLFW_OPENGL_CORE_PROFILE)
  win <- glfwCreateWindow title width height defaultMonitor
  -- now we pretend every thing is going to be ok
  glfwMakeContextCurrent win
  return win

isKeyPressed : GlfwWindow -> Char -> IO Bool
isKeyPressed win key = do 
  ev <- glfwGetKey win key 
  if ev == GLFW_PRESS
  then return True
  else return False

main : IO ()
main = do win <- initDisplay "Hello Idris" 640 480
          glfwSetInputMode win GLFW_STICKY_KEYS 1
          eventLoop win 0
          glfwDestroyWindow win
          glfwTerminate
          pure ()
       where 
         eventLoop : GlfwWindow -> Int -> IO ()
         eventLoop win ticks = do 
                      glfwPollEvents
                      key <- glfwGetFunctionKey win GLFW_KEY_ESCAPE
                      shouldClose <- glfwWindowShouldClose win
                      if shouldClose || key == GLFW_PRESS
                      then pure ()
                      else do 
                        eventLoop win (ticks+1)
