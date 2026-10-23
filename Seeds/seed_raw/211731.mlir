module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-103> : tensor<7x4x10x8xi64>}> : () -> tensor<7x4x10x8xi64>
    %1 = "tosa.const"() <{values = dense<81> : tensor<7x4x10x52xi64>}> : () -> tensor<7x4x10x52xi64>
    %2 = tosa.concat %0, %1 {axis = 3 : i32} : (tensor<7x4x10x8xi64>, tensor<7x4x10x52xi64>) -> tensor<7x4x10x60xi64>
    %3 = tosa.reduce_product %2 {axis = 2 : i32} : (tensor<7x4x10x60xi64>) -> tensor<7x4x1x60xi64>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %6 = tosa.negate %3, %4, %5 : (tensor<7x4x1x60xi64>, tensor<1xi64>, tensor<1xi64>) -> tensor<7x4x1x60xi64>
    %cast = tensor.cast %6 : tensor<7x4x1x60xi64> to tensor<*xi64>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    return
  }
}

