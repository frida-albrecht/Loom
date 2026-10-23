module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-60> : tensor<5x1x9xi64>}> : () -> tensor<5x1x9xi64>
    %1 = "tosa.const"() <{values = dense<[0, 2, 1]> : tensor<3xi32>}> : () -> tensor<3xi32>
    %2 = tosa.transpose %0 {perms = array<i32: 0, 2, 1>} : (tensor<5x1x9xi64>) -> tensor<5x9x1xi64>
    %cast = tensor.cast %2 : tensor<5x9x1xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

