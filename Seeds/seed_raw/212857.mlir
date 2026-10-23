module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<15> : tensor<9x6x8x7xi8>}> : () -> tensor<9x6x8x7xi8>
    %1 = "tosa.const"() <{values = dense<1.599000e+01> : tensor<3xf32>}> : () -> tensor<3xf32>
    %2 = tosa.reverse %0 {axis = 3 : i32} : (tensor<9x6x8x7xi8>) -> tensor<9x6x8x7xi8>
    %3 = tosa.add %2, %2 : (tensor<9x6x8x7xi8>, tensor<9x6x8x7xi8>) -> tensor<9x6x8x7xi8>
    %4 = tosa.sub %3, %3 : (tensor<9x6x8x7xi8>, tensor<9x6x8x7xi8>) -> tensor<9x6x8x7xi8>
    %5 = tosa.concat %4, %3 {axis = 0 : i32} : (tensor<9x6x8x7xi8>, tensor<9x6x8x7xi8>) -> tensor<18x6x8x7xi8>
    %6 = tosa.sigmoid %1 : (tensor<3xf32>) -> tensor<3xf32>
    %7 = tosa.ceil %6 : (tensor<3xf32>) -> tensor<3xf32>
    %cast = tensor.cast %5 : tensor<18x6x8x7xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %7 : tensor<3xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

