module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-12> : tensor<5xi64>}> : () -> tensor<5xi64>
    %1 = tosa.const_shape  {values = dense<[5, 1]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %2 = tosa.reshape %0, %1 : (tensor<5xi64>, !tosa.shape<2>) -> tensor<5x1xi64>
    %cast = tensor.cast %2 : tensor<5x1xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

