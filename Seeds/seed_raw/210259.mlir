module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.549200e+02> : tensor<4x6x7xf32>}> : () -> tensor<4x6x7xf32>
    %1 = "tosa.const"() <{values = dense<-1.199000e+02> : tensor<1x1x7xf32>}> : () -> tensor<1x1x7xf32>
    %2 = "tosa.const"() <{values = dense<-19> : tensor<6x7x8x9xi8>}> : () -> tensor<6x7x8x9xi8>
    %3 = tosa.pow %0, %1 : (tensor<4x6x7xf32>, tensor<1x1x7xf32>) -> tensor<4x6x7xf32>
    %4 = tosa.reduce_min %3 {axis = 2 : i32} : (tensor<4x6x7xf32>) -> tensor<4x6x1xf32>
    %5 = tosa.identity %4 : (tensor<4x6x1xf32>) -> tensor<4x6x1xf32>
    %6 = tosa.exp %5 : (tensor<4x6x1xf32>) -> tensor<4x6x1xf32>
    %7 = tosa.reciprocal %6 : (tensor<4x6x1xf32>) -> tensor<4x6x1xf32>
    %8 = tosa.clz %2 : (tensor<6x7x8x9xi8>) -> tensor<6x7x8x9xi8>
    %9 = tosa.maximum %7, %7 : (tensor<4x6x1xf32>, tensor<4x6x1xf32>) -> tensor<4x6x1xf32>
    %10 = tosa.ceil %9 : (tensor<4x6x1xf32>) -> tensor<4x6x1xf32>
    %11 = tosa.tanh %10 : (tensor<4x6x1xf32>) -> tensor<4x6x1xf32>
    %12 = tosa.minimum %8, %8 : (tensor<6x7x8x9xi8>, tensor<6x7x8x9xi8>) -> tensor<6x7x8x9xi8>
    %13 = tosa.reduce_min %12 {axis = 1 : i32} : (tensor<6x7x8x9xi8>) -> tensor<6x1x8x9xi8>
    %14 = tosa.exp %11 : (tensor<4x6x1xf32>) -> tensor<4x6x1xf32>
    %15 = tosa.abs %14 : (tensor<4x6x1xf32>) -> tensor<4x6x1xf32>
    %16 = tosa.sub %13, %13 : (tensor<6x1x8x9xi8>, tensor<6x1x8x9xi8>) -> tensor<6x1x8x9xi8>
    %17 = tosa.reduce_min %15 {axis = 0 : i32} : (tensor<4x6x1xf32>) -> tensor<1x6x1xf32>
    %18 = tosa.sigmoid %17 : (tensor<1x6x1xf32>) -> tensor<1x6x1xf32>
    %19 = tosa.sigmoid %18 : (tensor<1x6x1xf32>) -> tensor<1x6x1xf32>
    %cast = tensor.cast %16 : tensor<6x1x8x9xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %19 : tensor<1x6x1xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

