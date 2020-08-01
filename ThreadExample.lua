local threads = {}
local mutex = newMutex("threadSafetyExample")
local numThreads = 10
local eachAdd = 1000
 
sharedTotal = 0
 
local function safe()
  log("&7Started thread")
  sleep(150) --time for all threads to start up
  for i = 1, eachAdd do
    mutex.lock() --start of sensitive code
    sharedTotal = sharedTotal + 1
    mutex.unlock() --end of sensitive code
  end
  log("&7Thread done")
end
 
local function unsafe()
  log("&7Started thread")
  sleep(250) --time for all threads to start up
  for i = 1, eachAdd do
    sharedTotal = sharedTotal + 1
  end
  log("&8Thread done")
end
 
local function makeThreads( withFunc )
  for i = 1, numThreads do
    threads[#threads+1] = thread.new( withFunc )
  end
end
 
local function startThreads()
  for i=1, #threads do
    threads[i].start()
  end
 
  while true do
    local isOneRunning = false
    for i=1, #threads do
      isOneRunning = isOneRunning or (threads[i].getStatus()~="done")
    end
    if not isOneRunning then break end
  end
end
 
local function showResult()
  log(string.format("<&aExpected&f, &6Result&f> <&a%d&f, &6%d&f>",
  numThreads*eachAdd,
  sharedTotal
))
end
 
 
log("Choose example: &a&B&FSAFE&f or &c&B&FUNSAFE",
  function() --safe example
    threads = {}
    sharedTotal = 0
    makeThreads( safe )
    startThreads()
    showResult()
  end,
  function() --unsafe example
    threads = {}
    sharedTotal = 0
    makeThreads( unsafe )
    startThreads()
    showResult()
  end
)
