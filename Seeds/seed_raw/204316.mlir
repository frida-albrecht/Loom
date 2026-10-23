module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<162> : tensor<5x4xi64>}> : () -> tensor<5x4xi64>
    %1 = tosa.const_shape  {values = dense<[10, 2]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.reshape %0, %1 : (tensor<5x4xi64>, !tosa.shape<2>) -> tensor<10x2xi64>
    %3 = tosa.concat %2, %2 {axis = 0 : i32} : (tensor<10x2xi64>, tensor<10x2xi64>) -> tensor<20x2xi64>
    %4 = tosa.clz %3 : (tensor<20x2xi64>) -> tensor<20x2xi64>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %6 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %7 = tosa.negate %4, %5, %6 : (tensor<20x2xi64>, tensor<1xi64>, tensor<1xi64>) -> tensor<20x2xi64>
    %cast = tensor.cast %7 : tensor<20x2xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

