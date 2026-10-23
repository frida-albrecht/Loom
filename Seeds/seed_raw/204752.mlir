module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-115> : tensor<1x5x2x5xi32>}> : () -> tensor<1x5x2x5xi32>
    %1 = "tosa.const"() <{values = dense<-1.500200e+02> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = tosa.reduce_product %0 {axis = 0 : i32} : (tensor<1x5x2x5xi32>) -> tensor<1x5x2x5xi32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %5 = tosa.negate %2, %3, %4 : (tensor<1x5x2x5xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<1x5x2x5xi32>
    %6 = tosa.argmax %5 {axis = 0 : i32} : (tensor<1x5x2x5xi32>) -> tensor<5x2x5xi32>
    %7 = tosa.bitwise_not %6 : (tensor<5x2x5xi32>) -> tensor<5x2x5xi32>
    %8 = tosa.reciprocal %1 : (tensor<1xf32>) -> tensor<1xf32>
    %9 = tosa.clamp %8 {max_val = 4.900000e+01 : f32, min_val = -3.900000e+01 : f32} : (tensor<1xf32>) -> tensor<1xf32>
    %10 = tosa.argmax %7 {axis = 0 : i32} : (tensor<5x2x5xi32>) -> tensor<2x5xi32>
    %11 = tosa.argmax %10 {axis = 1 : i32} : (tensor<2x5xi32>) -> tensor<2xi32>
    %cast = tensor.cast %9 : tensor<1xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %11 : tensor<2xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

