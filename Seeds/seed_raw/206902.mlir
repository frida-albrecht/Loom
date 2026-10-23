module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-101> : tensor<10x7x3x6xi64>}> : () -> tensor<10x7x3x6xi64>
    %1 = tosa.const_shape  {values = dense<[1, 1, 1, 3]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %2 = tosa.tile %0, %1 : (tensor<10x7x3x6xi64>, !tosa.shape<4>) -> tensor<10x7x3x18xi64>
    %3 = tosa.concat %2, %2 {axis = 2 : i32} : (tensor<10x7x3x18xi64>, tensor<10x7x3x18xi64>) -> tensor<10x7x6x18xi64>
    %4 = tosa.maximum %3, %3 : (tensor<10x7x6x18xi64>, tensor<10x7x6x18xi64>) -> tensor<10x7x6x18xi64>
    %cast = tensor.cast %4 : tensor<10x7x6x18xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

