using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using System.Text;

namespace CrossTask
{
    class NoDecisionException:Exception
    {
        public NoDecisionException() : base() { }
        public NoDecisionException(string message) : base(message) { }
        public NoDecisionException(string message, Exception inner) : base(message, inner) { }
        public NoDecisionException(SerializationInfo info, StreamingContext context) : base(info, context) { }
    }
}
