module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-8.907000e+01> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<83> : tensor<7x4xi64>}> : () -> tensor<7x4xi64>
    %2 = "tosa.const"() <{values = dense<-36> : tensor<7x47xi64>}> : () -> tensor<7x47xi64>
    %3 = tosa.log %0 : (tensor<f32>) -> tensor<f32>
    %4 = tosa.concat %1, %2 {axis = 1 : i32} : (tensor<7x4xi64>, tensor<7x47xi64>) -> tensor<7x51xi64>
    %5 = tosa.minimum %4, %4 : (tensor<7x51xi64>, tensor<7x51xi64>) -> tensor<7x51xi64>
    %6 = tosa.bitwise_or %5, %4 : (tensor<7x51xi64>, tensor<7x51xi64>) -> tensor<7x51xi64>
    %7 = tosa.bitwise_and %6, %6 : (tensor<7x51xi64>, tensor<7x51xi64>) -> tensor<7x51xi64>
    %cast = tensor.cast %3 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %7 : tensor<7x51xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}

