module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-72> : tensor<10x3xi64>}> : () -> tensor<10x3xi64>
    %1 = tosa.const_shape  {values = dense<[1, 30, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %2 = tosa.reshape %0, %1 : (tensor<10x3xi64>, !tosa.shape<3>) -> tensor<1x30x1xi64>
    %cast = tensor.cast %2 : tensor<1x30x1xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

