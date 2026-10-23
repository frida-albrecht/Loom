module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<10> : tensor<10x10x6x5xi64>}> : () -> tensor<10x10x6x5xi64>
    %1 = tosa.reduce_min %0 {axis = 2 : i32} : (tensor<10x10x6x5xi64>) -> tensor<10x10x1x5xi64>
    %2 = tosa.const_shape  {values = dense<[1, 500]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %3 = tosa.reshape %1, %2 : (tensor<10x10x1x5xi64>, !tosa.shape<2>) -> tensor<1x500xi64>
    %4 = tosa.reduce_product %3 {axis = 1 : i32} : (tensor<1x500xi64>) -> tensor<1x1xi64>
    %5 = tosa.concat %4, %4 {axis = 1 : i32} : (tensor<1x1xi64>, tensor<1x1xi64>) -> tensor<1x2xi64>
    %cast = tensor.cast %5 : tensor<1x2xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

