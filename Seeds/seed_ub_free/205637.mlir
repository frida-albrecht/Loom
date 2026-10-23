module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-18> : tensor<1x6x9x7xi8>}> : () -> tensor<1x6x9x7xi8>
    %1 = "tosa.const"() <{values = dense<-3> : tensor<1x6x9x1xi8>}> : () -> tensor<1x6x9x1xi8>
    %2 = "tosa.const"() <{values = dense<-1.952000e+02> : tensor<f32>}> : () -> tensor<f32>
    %3 = "tosa.const"() <{values = dense<-5.884000e+01> : tensor<f32>}> : () -> tensor<f32>
    %4 = tosa.add %0, %1 : (tensor<1x6x9x7xi8>, tensor<1x6x9x1xi8>) -> tensor<1x6x9x7xi8>
    %5 = tosa.reverse %4 {axis = 0 : i32} : (tensor<1x6x9x7xi8>) -> tensor<1x6x9x7xi8>
    %c0 = "tosa.const"() <{values = dense<0.0> : tensor<f32>}> : () -> tensor<f32>
    %s2 = tosa.maximum %2, %c0 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %c1 = "tosa.const"() <{values = dense<1.0> : tensor<f32>}> : () -> tensor<f32>
    %s3 = tosa.maximum %3, %c1 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %6 = tosa.pow %s2, %s3 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %7 = tosa.minimum %5, %4 : (tensor<1x6x9x7xi8>, tensor<1x6x9x7xi8>) -> tensor<1x6x9x7xi8>
    %8 = tosa.floor %6 : (tensor<f32>) -> tensor<f32>
    %9 = tosa.argmax %7 {axis = 3 : i32} : (tensor<1x6x9x7xi8>) -> tensor<1x6x9xi32>
    %10 = tosa.clamp %8 {max_val = 7.300000e+01 : f32, min_val = 1.400000e+01 : f32} : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %9 : tensor<1x6x9xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %10 : tensor<f32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}