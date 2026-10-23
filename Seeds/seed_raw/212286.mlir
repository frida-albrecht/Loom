module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-96.8399963> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<-176> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<197> : tensor<i32>}> : () -> tensor<i32>
    %3 = "tosa.const"() <{values = dense<120> : tensor<4xi64>}> : () -> tensor<4xi64>
    %4 = tosa.tanh %0 : (tensor<f32>) -> tensor<f32>
    %5 = tosa.tanh %4 : (tensor<f32>) -> tensor<f32>
    %6 = tosa.intdiv %1, %2 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %7 = tosa.add %6, %6 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %8 = tosa.reduce_min %3 {axis = 0 : i32} : (tensor<4xi64>) -> tensor<1xi64>
    %9 = tosa.rsqrt %5 : (tensor<f32>) -> tensor<f32>
    %10 = tosa.reduce_product %8 {axis = 0 : i32} : (tensor<1xi64>) -> tensor<1xi64>
    %11 = tosa.bitwise_or %7, %6 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %12 = tosa.reduce_min %10 {axis = 0 : i32} : (tensor<1xi64>) -> tensor<1xi64>
    %13 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %14 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %15 = tosa.negate %11, %13, %14 : (tensor<i32>, tensor<1xi32>, tensor<1xi32>) -> tensor<i32>
    %16 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %17 = "tosa.const"() <{values = dense<0> : tensor<1xi64>}> : () -> tensor<1xi64>
    %18 = tosa.negate %12, %16, %17 : (tensor<1xi64>, tensor<1xi64>, tensor<1xi64>) -> tensor<1xi64>
    %19 = tosa.add %11, %15 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %cast = tensor.cast %9 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %18 : tensor<1xi64> to tensor<*xi64>
    %cast_1 = tensor.cast %19 : tensor<i32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    return
  }
}

