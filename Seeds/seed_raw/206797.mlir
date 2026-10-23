module {
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-182> : tensor<5xi64>}> : () -> tensor<5xi64>
    %1 = "tosa.const"() <{values = dense<-111> : tensor<1xi64>}> : () -> tensor<1xi64>
    %2 = "tosa.const"() <{values = dense<-1.277500e+02> : tensor<f32>}> : () -> tensor<f32>
    %3 = tosa.logical_left_shift %0, %1 : (tensor<5xi64>, tensor<1xi64>) -> tensor<5xi64>
    %4 = tosa.sigmoid %2 : (tensor<f32>) -> tensor<f32>
    %5 = tosa.clamp %4 {max_val = 2.200000e+01 : f32, min_val = -5.400000e+01 : f32} : (tensor<f32>) -> tensor<f32>
    %6 = tosa.reverse %3 {axis = 0 : i32} : (tensor<5xi64>) -> tensor<5xi64>
    %7 = tosa.bitwise_xor %6, %3 : (tensor<5xi64>, tensor<5xi64>) -> tensor<5xi64>
    %8 = tosa.rsqrt %5 : (tensor<f32>) -> tensor<f32>
    %9 = tosa.concat %7, %6 {axis = 0 : i32} : (tensor<5xi64>, tensor<5xi64>) -> tensor<10xi64>
    %cast = tensor.cast %8 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %9 : tensor<10xi64> to tensor<*xi64>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}

