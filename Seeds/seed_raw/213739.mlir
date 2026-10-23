module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<7> : tensor<5x4xi8>}> : () -> tensor<5x4xi8>
    %1 = "tosa.const"() <{values = dense<-15> : tensor<5x4xi8>}> : () -> tensor<5x4xi8>
    %2 = "tosa.const"() <{values = dense<-5.283000e+01> : tensor<7xf32>}> : () -> tensor<7xf32>
    %3 = tosa.bitwise_or %0, %1 : (tensor<5x4xi8>, tensor<5x4xi8>) -> tensor<5x4xi8>
    %4 = tosa.maximum %3, %3 : (tensor<5x4xi8>, tensor<5x4xi8>) -> tensor<5x4xi8>
    %5 = tosa.reduce_min %4 {axis = 0 : i32} : (tensor<5x4xi8>) -> tensor<1x4xi8>
    %6 = "tosa.const"() <{values = dense<[0, 1]> : tensor<2xi32>}> : () -> tensor<2xi32>
    %7 = tosa.transpose %5 {perms = array<i32: 0, 1>} : (tensor<1x4xi8>) -> tensor<1x4xi8>
    %8 = tosa.bitwise_xor %7, %5 : (tensor<1x4xi8>, tensor<1x4xi8>) -> tensor<1x4xi8>
    %9 = tosa.clamp %8 {max_val = 38 : i8, min_val = -17 : i8} : (tensor<1x4xi8>) -> tensor<1x4xi8>
    %10 = tosa.ceil %2 : (tensor<7xf32>) -> tensor<7xf32>
    %11 = tosa.reduce_product %9 {axis = 1 : i32} : (tensor<1x4xi8>) -> tensor<1x1xi8>
    %12 = tosa.reduce_min %11 {axis = 1 : i32} : (tensor<1x1xi8>) -> tensor<1x1xi8>
    %13 = tosa.bitwise_or %12, %11 : (tensor<1x1xi8>, tensor<1x1xi8>) -> tensor<1x1xi8>
    %cast = tensor.cast %10 : tensor<7xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %13 : tensor<1x1xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

