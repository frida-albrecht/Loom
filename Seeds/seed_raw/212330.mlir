module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-133> : tensor<1x10xi64>}> : () -> tensor<1x10xi64>
    %1 = tosa.const_shape  {values = dense<[2, 1, 5]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %2 = tosa.reshape %0, %1 : (tensor<1x10xi64>, !tosa.shape<3>) -> tensor<2x1x5xi64>
    %cast = tensor.cast %2 : tensor<2x1x5xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

