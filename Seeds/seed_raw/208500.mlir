module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<152> : tensor<5x2xi64>}> : () -> tensor<5x2xi64>
    %1 = "tosa.const"() <{values = dense<-24> : tensor<5x1xi64>}> : () -> tensor<5x1xi64>
    %2 = "tosa.const"() <{values = dense<-1.824400e+02> : tensor<f32>}> : () -> tensor<f32>
    %3 = tosa.arithmetic_right_shift %0, %1 {round = false} : (tensor<5x2xi64>, tensor<5x1xi64>) -> tensor<5x2xi64>
    %4 = tosa.reduce_product %3 {axis = 1 : i32} : (tensor<5x2xi64>) -> tensor<5x1xi64>
    %5 = tosa.reciprocal %2 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %4 : tensor<5x1xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %5 : tensor<f32> to tensor<*xf32>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

